class ApiActionDescriptionView
  constructor: (options)->
    @converter = new Showdown.converter()

    @renderDescription(options)
    @handleFormSubmissions(options)

  renderDescription: (options, text = null)->
    options.desciptionContainer.html(@converter.makeHtml(text || options.desciptionContainer.text()))

  handleFormSubmissions: (options)->
    textarea = $('textarea', form)

    options.showHideLink.on 'click', =>
      options.formContainer.show()
      options.showHideLink.hide()
      options.previewContainer.html(@converter.makeHtml(textarea.val()))
      false

    form = $('form', options.formContainer)

    textarea.on "keyup", =>
      options.previewContainer.html(@converter.makeHtml(textarea.val()))


    form.on "ajax:success", (xhr, data)=>
      options.formContainer.hide()
      options.showHideLink.show()

      @renderDescription(options,data.description)

    form.on "ajax:error", (xhr, data)->
      alert("Failed to save the description. Try again.")



@ApiActionDescriptionView = ApiActionDescriptionView
