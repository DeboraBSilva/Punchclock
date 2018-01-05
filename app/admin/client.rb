ActiveAdmin.register Client do
  permit_params :name, :company, :company_id

  filter :company, if: proc { current_admin_user.is_super? }
  filter :name

  index do
    selectable_column
    column :company if current_admin_user.is_super?
    column :name
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      if current_admin_user.is_super?
        f.input :company
      else
        f.input :company_id, as: :hidden, input_html: { value: current_admin_user.company_id }
      end
    end
    f.actions
  end
end