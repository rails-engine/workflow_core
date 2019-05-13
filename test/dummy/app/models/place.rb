# frozen_string_literal: true

class Place < WorkflowCore::Place
  def builtin?
    false
  end

  def append_to_graph(g, prev: nil, arc_label: "", nodes: {})
    key = "p_#{id}"
    unless nodes[key]
      nodes[key] = Graphviz::Node.new("p.#{id}#{": #{name}" if name.present?}", shape: "circle")
      g << nodes[key]
    end
    current = nodes[key]

    prev.connect(current, label: arc_label) if prev && !prev.connected?(current)

    if output_transition
      next_node = nodes["t_#{output_transition.id}"]
      if !next_node
        output_transition.append_to_graph(g, prev: current, nodes: nodes)
      else
        current.connect(next_node, label: arc_label)
      end
    end

    g
  end
end

require_dependency "places"
