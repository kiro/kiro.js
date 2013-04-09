docs = window.BC.namespace("docs")
docs.examples = window.BC.namespace("docs.examples")
bootstrap = window.BC.namespace("bootstrap")
models = window.BC.namespace("models")
store = window.BC.namespace("store")

$.extend(this, bootstrap, models, docs, store)

docs.examples.projects = -> section(h1("Projects"),
  docs.code.projects()

  example("Javascript projects", "Blatantly stolen from angularjs.", ->
    byId = (id) -> (item) -> id and item._id.$oid == id.$oid
    content = model("")

    projects = collection([])
    mongoLab(projects, 'examples', 'projects')

    projectForm = (project) ->
      console.log(project)
      form(
        Name: input.text({required: true}, bind(project.name))
        Site: input.text({required: true, type: 'url'}, bind(project.site))
        Description: textarea({required: true}, bind(project.description))
        actions: [
          a(class: 'btn btn-primary', "Save", ->
            if !projects.find(byId(project._id))
              projects.add(project)
            content(projectList())
          )
          a(class: 'btn', 'Cancel', -> content(projectList()))
          a(class: 'btn btn-danger', 'Delete', ->
            projects.remove(byId(project._id))
            content(projectList())
          )
        ]
      )

    addProject = () -> projectForm(object(name: "", site: "", description: ""))

    projectList = () ->
      query = model("")
      div(
        input.text(placeholder: "Search", query)
          .on('keyup', -> projects.filter(query.toLowerCase()))
        table(thead(tr(th(
          td("Project"),
          td("Description"),
          td(a('+', -> content(addProject())))
        )))).foreach(projects, (project) -> tr(
          td(a({href: project.site}, project.name))
          td(project.description)
          td(a('Edit', -> content(projectForm(project))))
        ))
      )

    content(projectList())

    body(
      div(content)
    )
  )
)