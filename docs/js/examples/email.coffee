docs = window.BC.namespace("docs")
docs.examples = window.BC.namespace("docs.examples")
bootstrap = window.BC.namespace("bootstrap")
models = window.BC.namespace("models")

$.extend(this, bootstrap, models, docs)

docs.examples.email = -> section(h1("Email"),
  docs.code.email()

  example("Email client", "", ->
    currentUser = "kiril.minkov@gmail.com"
    data = object(docs.examples.emailData())

    emails = collection(data.mail)
    selectedFolder = model()
    selectedEmail = model()

    emailList = () ->
      table().foreach(emails, (email) ->
        tr(
          td().span2(type.label().important('important') if email.important)
          td().span3(strong(email.from))
          td().span7(strong(email.subject))
        ).on('click', -> selectedEmail(email))
         .bindClass(selectedEmail, 'info', -> selectedEmail() == email)
      )

    rightContent = model(emailList())

    sendEmail = (baseEmail) ->
      form.horizontal(
        From: currentUser
        To: input.text(baseEmail.from)
        Subject: input.text(baseEmail.subject)
        Email: textarea(baseEmail.message)
      )

    leftPanel = () ->
      div().span2(
        button("New", -> rightContent(sendEmail(object(to: "", subject: "", message: ""))))
        ul().foreach(data.folders, (folder) ->
          li(folder)
            .on('click', ->
              selectedFolder(folder)
              emails.filter((email) -> _.contains(emails.folders, folder)))
            .bindClass(selectedFolder, 'selected', -> selectedFolder() == folder)
        )
      )

    rightPanel = () ->
      div().span10(
        button.group(
          button(icon.trash, "Delete", ->
            selectedEmail().folders.length = 0
            selectedEmail().folders.push('trash')
          ).bindDisabled(negate(selectedEmail))

          button(icon.forward, "Forward", ->
            rightContent(sendEmail(object(
              subject: "FW: " + selectedEmail.subject
            )))
          ).bindDisabled(negate(selectedEmail))

          button(icon.pencil, "Reply", ->
            rightContent(sendEmail(object(
              to: selectedEmail().from,
              subject: "RE: " + selectedEmail.subject
            )))
          ).bindDisabled(negate(selectedEmail))
        )
        div(rightContent)
      )

    body(
      div.container.fluid(
        div.row.fluid(
          leftPanel()
          rightPanel()
        )
      )
    )
  )
)