docs = window.BC.namespace("docs")
docs.examples = window.BC.namespace("docs.examples")
bootstrap = window.BC.namespace("bootstrap")
models = window.BC.namespace("models")

$.extend(this, bootstrap, models, docs)

body = (items...) -> div(items)

docs.examples.email = -> section(h1("Email"),
  docs.code.email()

  example("Email client", "", ->
    byFolder = (folder) -> (email) -> email.folders.contains(folder)
    byId = (id) -> (item) -> item.id == id

    currentUser = "kiril.minkov@gmail.com"
    data = object(docs.examples.emailData())

    selectedFolder = model("inbox")
    data.mail.filter(byFolder('inbox'))
    selectedEmail = model()

    nextId = (->
      value = 100000
      (-> value++)
    )()

    email = (init) ->
      object(
        $.extend(
          {"id": "mail_" + nextId(),
          "contact_id": data.contacts.at(0).id,
          "folders": ['sent'],
          "time": new Date().getTime(),
          "subject": ""
          "message": ""},
          init
        )
      )

    emailList = () ->
      table().foreach(data.mail, (email) ->
        contact = data.contacts.find(byId(email.contact_id))

        tr(
          td().span2(type.label().important('important') if email.important)
          td().span3(strong(contact.firstName + " " + contact.lastName))
          td().span7(strong(email.subject))
        ).on('click', -> selectedEmail(email))
         .bindClass(selectedEmail, -> 'info' if selectedEmail() == email)
      )

    rightContent = model(emailList())

    sendEmail = (email) ->
      toSelector = select(bind(email.contact_id))
        .foreach(data.contacts, (contact) -> option(contact.email, contact.id))

      form.horizontal(
        From: span(currentUser)
        To: toSelector
        Subject: input.text(bind(email.subject))
        Email: textarea(bind(email.message)),
        actions: [
          button("Send", ->
            data.mail.add(email)
            rightContent(emailList())
          ),
          button("Cancel", -> rightContent(emailList()))
        ]
      )

    leftPanel = () ->
      div().span2(
        button("New", -> rightContent(sendEmail(email())))
        br()
        pills.stacked().foreach(data.folders, (folder) ->
          pill(folder, ->
              selectedEmail("")
              selectedFolder(folder)
              data.mail.filter(byFolder(folder)))
            .bindClass(selectedFolder, -> 'active' if selectedFolder() == folder)
        )
      )

    rightPanel = () ->
      div().span10(
        button.group(
          button(icon.trash, "Delete", ->
            selectedEmail(null).folders(['trash'])
          ).bindDisabled(negate(selectedEmail))

          dropdown(
            button("Move").bindDisabled(negate(selectedEmail))
            (a(folder, -> selectedEmail(null).folders([folder])) for folder in data.folders)
          )

          button(icon.forward, "Forward", ->
            rightContent(sendEmail(email(
              subject: "FW: " + selectedEmail(null).subject
            )))
          ).bindDisabled(negate(selectedEmail))

          button(icon.pencil, "Reply", ->
            rightContent(sendEmail(email(
              contact_id: selectedEmail().contact_id,
              subject: "RE: " + selectedEmail(null).subject
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