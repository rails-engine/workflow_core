# frozen_string_literal: true

user_1 = User.create! name: "Alice"
user_2 = User.create! name: "Bob"
user_3 = User.create! name: "Carol"

workflow = Workflow.create! name: "Request for Absence"

# Configure form

form = workflow.form
reason_field = form.fields.create! name: "reason", label: "Reason", type: "Fields::TextField"
reason_field.validations.presence = true
reason_field.save!

tmp_p = workflow.start_place

# Fill form stage

fill_form_t = tmp_p.create_output_transition! type: "Transitions::Variants::UserTask",
                                              workflow: workflow,
                                              name: "Fill request form"
tmp_p.update! output_transition_id: fill_form_t.id

tmp_p = fill_form_t.output_places.create! type: "Place",
                                          workflow: workflow,
                                          name: "Filled form"

# Assign approvers and make approval stage

tmp_t = tmp_p.create_output_transition! type: "Transitions::Variants::AssigningAssignees",
                                        workflow: workflow,
                                        name: "Assign approvers"
tmp_p.update! output_transition_id: tmp_t.id
tmp_t.options.assign_to = "specific"
tmp_t.options.assignee_user_ids = [user_2.id, user_3.id]
tmp_t.save!

tmp_p = tmp_t.output_places.create! type: "Place",
                                    workflow: workflow,
                                    name: "Pending approval"

decision_t = tmp_p.create_output_transition! type: "Transitions::Variants::Decision",
                                             workflow: workflow,
                                             name: "Make decision"
tmp_p.update! output_transition_id: decision_t.id

approved_p = decision_t.output_places.create! type: "Place",
                                              workflow: workflow,
                                              name: "Approved"
rejected_p = decision_t.output_places.create! type: "Place",
                                              workflow: workflow,
                                              name: "Rejected"

decision_t.options.field_overrides.build name: reason_field.name, accessibility: "readonly"
decision_t.options.actions.build text: "Approve", value: "1", place_id: approved_p.id
decision_t.options.actions.build text: "Reject", value: "2", place_id: rejected_p.id
decision_t.save!

# Back to fill form stage if rejected

tmp_t = rejected_p.create_output_transition! type: "Transitions::Variants::AssigningAssignees",
                                             workflow: workflow,
                                             name: "Assign to applicant"
rejected_p.update! output_transition_id: tmp_t.id

tmp_t.output_places.create! type: "Place",
                            workflow: workflow,
                            name: "Refill request form",
                            output_transition_id: fill_form_t.id

# Applicant review stage

tmp_t = approved_p.create_output_transition! type: "Transitions::Variants::AssigningAssignees",
                                             workflow: workflow,
                                             name: "Assign to applicant"
approved_p.update! output_transition_id: tmp_t.id

tmp_p = tmp_t.output_places.create! type: "Place",
                                    workflow: workflow,
                                    name: "Pending review"

tmp_t = tmp_p.create_output_transition! type: "Transitions::Variants::UserTask",
                                        workflow: workflow,
                                        name: "Review request form"
tmp_p.update! output_transition_id: tmp_t.id
tmp_t.options.field_overrides.build name: reason_field.name, accessibility: "readonly"
tmp_t.save!

tmp_p = tmp_t.output_places.create! type: "Place",
                                    workflow: workflow,
                                    name: "Reviewed"

# Done

tmp_t = tmp_p.create_output_transition! type: "Transitions::End",
                                        workflow: workflow,
                                        name: "Workflow complete"
tmp_p.update! output_transition_id: tmp_t.id

tmp_t.output_places.create! type: "Places::EndPlace",
                            workflow: workflow
