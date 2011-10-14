module ApplicationHelper
  # Creates a submit button with the given name with a cancel link
  # Accepts two arguments: Form object and the cancel link name
  def submit_or_cancel(form, name='Annuler')
    (form.submit "Valider") + " | " +
    link_to(name, 'javascript:history.go(-1);', :class => 'cancel')
  end

  def only_cancel()
    link_to('Annuler', 'javascript:history.go(-1);', :class => 'cancel')
  end
end
