# frozen_string_literal: true

class Workflow < WorkflowCore::Workflow
  has_one :form, dependent: :destroy
  has_many :nested_forms
  has_many :fields

  after_create :auto_create_form!
  after_create :auto_create_start_place!

  validates :name,
            presence: true

  # Graphviz::output(g, path: "test.pdf")
  def to_graph
    g = Graphviz::Graph.new # rankdir: "LR"
    start_place.append_to_graph(g, nodes: {})
  end

  def load_from_bpmn!(bpmn_xml)
    c = Bpmn::DefinitionContainer.parse(bpmn_xml)
    return unless c

    tokens.delete_all
    instances.delete_all

    transitions.destroy_all
    places.destroy_all

    place = create_start_place! type: "Places::StartPlace"
    node_queue = c.start_event.outgoing_ids

    convert_node_type = lambda do |node|
      case node.node_type
      when :task
        "Transitions::Sequence"
      when :user_task
        "Transitions::Sequence"
      when :start_event
        "Transitions::Start"
      when :end_event
        "Transitions::End"
      when :parallel_gateway
        node.outgoing_ids.size == 1 ? "Transitions::Synchronization" : "Transitions::ParallelSplit"
      when :exclusive_gateway
        node.outgoing_ids.size == 1 ? "Transitions::SimpleMerge" : "Transitions::ExclusiveChoice"
      else
        raise NotImplementedError, "#{node.node_type} doesn't support yet."
      end
    end

    transaction do
      loop do
        break if node_queue.blank?

        target_id = node_queue.pop
        curr_node = c[target_id]
        raise "#{target_id} not found!" unless curr_node

        # puts "1 #{curr_node.name} #{curr_node.node_type} from #{curr_node.try(:incoming_ids)&.join(", ") || curr_node.try(:source_id)} to #{curr_node.try(:outgoing_ids)&.join(", ") || curr_node.try(:target_id)}"

        if curr_node.flow?
          target_id = curr_node.target_id
          target = c[curr_node.target_id]
          raise "#{target_id} not found!" unless target

          target_transition = transitions.find_by uid: target.id
          transition = transitions.find_by uid: c[curr_node.source_id].id
          if transition && target_transition
            transition.output_places.create! output_transition: target_transition,
                                             type: "Place",
                                             workflow: self
            next
          elsif transition
            place = transition.output_places.create! type: "Place", workflow: self
          end

          curr_node = target
          # puts "2 #{curr_node.name} #{curr_node.node_type} from #{curr_node.try(:incoming_ids)&.join(", ") || curr_node.try(:source_id)} to #{curr_node.try(:outgoing_ids)&.join(", ") || curr_node.try(:target_id)}"
        end

        transition = transitions.find_by uid: c[curr_node.id].id
        transition ||= place.create_output_transition! name: curr_node.name, uid: curr_node.id,
                                                       type: convert_node_type.call(curr_node),
                                                       workflow: self

        dup_place = places.find_by input_transition_id: place.input_transition_id, output_transition_id: transition.id
        if dup_place
          place.destroy
          place = dup_place
        else
          place.update! output_transition: transition
        end

        children = curr_node.outgoing_ids - transitions.where(uid: curr_node.outgoing_ids).map(&:uid)
        if children.empty?
          transition.output_places.create! type: "Place",
                                           workflow: self
        end
        node_queue = children + node_queue
        # puts "===="
        # puts node_queue.join(", ")
        # puts "===="
      end
    end
  end

  private

    def auto_create_form!
      create_form! type: "Form", name: SecureRandom.hex(3)
    end

    def auto_create_start_place!
      create_start_place! type: "Places::StartPlace"
    end
end
