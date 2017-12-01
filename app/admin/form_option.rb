ActiveAdmin.register FormOption do
  permit_params :form_name, :dependencia_desc, :state_or_city, :deadline, {sections_to_show: []}
  menu label: "Opções do Questionário", priority: 4

  before_save do |form_option|
    form_option.form_assembly_params = form_option.sections_to_form_assembly_params
  end

  filter :form_name, label: 'Questionário', as: :select, collection: %w[baseline follow_up]
  filter :dependencia_desc, as: :select, collection: %w[Estadual Municipal Federal], label: 'Rede de ensino'
  filter :state_or_city_cont, label: 'Código IBGE do Estado ou cidade'

  index title: 'Opções do Questionário' do
    column 'Questionário', :form_name
    column 'Seções habilitadas', :sections_to_show
    column 'Rede de ensino', :dependencia_desc
    column 'Estado ou cidade', :name_state_or_city
    column 'Prazo de entrega', :deadline
    actions
  end

  form title: 'Inserir opções de seções por rede de ensino' do |f|
    inputs do
      input :form_name, as: :select, collection: %w[baseline follow_up], label: 'Questionário'
      input :dependencia_desc, as: :select, collection: %w[Estadual Municipal], label: 'Rede de ensino'
      input :state_or_city, label: 'Código ibge do estado ou municipio'
      input :sections_to_show, as: :check_boxes, collection: %w[A B C D E F], label: 'Habilitar seções'
      input :deadline, as: :datepicker, datepicker_options: { dateFormat: 'dd/mm/yy' }
    end

    actions
  end

  controller do
    skip_before_action :authenticate_active_admin_user
  end
end
