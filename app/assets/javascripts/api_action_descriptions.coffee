class MarkdownView
  constructor: (options)->
    @handleFormSubmissions(options)

    form = $('form', options.formContainer)
    textarea = $('textarea', options.form)

    options.previewButton.on "ajax:before", (event)->
      options.previewButton.data 'params', description: textarea.val()

    options.previewButton.on "ajax:beforeSend", (event, xhr, settings)->
      settings.url = options.previewButton.data('path')

  handleFormSubmissions: (options)->
    textarea = $('textarea', form)

    options.showHideLink.on 'click', =>
      options.formContainer.show()
      options.showHideLink.hide()
      options.descriptionContainer.hide()
      false

    form = $('form', options.formContainer)

    form.on "ajax:success", (xhr, data)=>
      options.formContainer.hide()
      options.showHideLink.show()
      options.descriptionContainer.show()

    form.on "ajax:error", (xhr, data)->
      alert("Failed to save the description. Try again.")



@MarkdownView = MarkdownView
