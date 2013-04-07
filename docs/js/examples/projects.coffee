docs = window.BC.namespace("docs")
docs.examples = window.BC.namespace("docs.examples")
bootstrap = window.BC.namespace("bootstrap")
models = window.BC.namespace("models")
store = window.BC.namespace("store")

$.extend(this, bootstrap, models, docs, store)

docs.examples.projects = -> section(h1("Projects"),
  docs.code.projects()

  example("Javascript projects", "Blatantly stolen from angularjs.", ->
    byId = (id) -> (item) -> item._id == id
    content = model("")

    projects = collection([])
    mongoLab(projects, 'examples', 'projects')

    projectForm = (project) ->
      form(
        Name: input.text({required: true}, bind(project.name))
        Site: input.text({required: true, type: 'url'}, bind(project.site))
        Description: textarea({required: true}, bind(project.description))
        "": [
          a(class: 'btn', href: '#/examples/projects/list', "Save",
            -> projects.addOrUpdate(byId(project._id), project)),
          a(class: 'btn', href: '#/examples/projects/list', 'Cancel')
          a(class: 'btn btn-danger', href: '#/examples/projects/list', 'Delete',
            -> projects.remove(byId(project._id)))
            .bindVisible(bind(project._id))
        ]
      )

    editProject = (id) -> projectForm(projects.find(byId(id)).clone())
    addProject = () -> projectForm(object(name: "", site: "", description: ""))

    projectList = () ->
      query = model("")
      div(
        input.text(placeholder: "Search", query).on('keyup',
          -> projects.filter((item) -> JSON.stringify(item).indexOf(query) != -1))
        table(thead(tr(th(
          td("Project"),
          td("Description"),
          td(a({href:'#/examples/projects/new'}, '+'))
        )))).foreach(projects, (project) -> tr(
          td(a({href: project.site}, project.name))
          td(project.description)
          td(a(href: '#/examples/projects/edit/' + project.id), "Edit")
        ))
      )

      div(input.text(placeholder: 'Text'))

    app = Sammy('#projects', ->
      this.get('#/examples/projects/', -> content(projectList()))
      this.get('#/examples/projects/edit/:id', -> content(editProject(this.params['id'])))
      this.get('#/examples/projects/new', -> content(addProject()))
    )

    app.run("#/examples/projects/")

    body(
      content
    )
  , id: 'projects')
)