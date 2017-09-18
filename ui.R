shinyUI(pageWithSidebar(
    headerPanel("Probability Qual Prep"),
      sidebarPanel(
        checkboxGroupInput("checkClass", label = h4("Class"), 
                           choices = list("519" = 1, "532" = 2),
                           selected = c(1,2)),
        h5("(Optional)"),
        h5("Select sets:"),
        textInput("in519",label = h5("519"), value = "c(1,2,3,4,5,6,7)"),
        textInput("in532",label = h5("532"), value = "c(1,2,3,4,5,6)"),
        actionButton("action", label = "Shuffle", icon("refresh")),
        textInput("goTo",label = h5("Choose a specific question:"), value = ""),
        actionButton("goButton", label = "Go!"),
        helpText("Answers by Dr. Ward"),
        helpText("Developed by Gui Gomes"),
        width = 3),
        mainPanel(
          h3(htmlOutput("Title")),
          tabsetPanel("inTabset",
          tabPanel(
            titlePanel("Question"),
            # Use imageOutput to place the image on the page
            imageOutput("myImage")
          ),
          tabPanel(
            titlePanel("Answer"),
            imageOutput("myImage1")
          )
      )
    )
  )
)

