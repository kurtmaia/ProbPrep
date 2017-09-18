sets <- matrix(c(1,1,16,
          1,2,14,
          1,3,14,
          1,4,12,
          1,5,12,
          1,6,11,
          1,7,11,
          2,1,14,
          2,2,14,
          2,3,14,
          2,4,9,
          2,5,13,
          2,6,9),byrow=T,13,3)
colnames(sets) <- c("class","set","nex")
sets <- data.frame(sets)

shinyServer(function(input, output, clientData, session) {

  observe({
  if (1%in%input$checkClass){
  updateTextInput(session, "in519",
                  label = "519",
                  value = "c(1,2,3,4,5,6,7)"
  )}
  else if (!(1%in%input$checkClass)){
      updateTextInput(session, "in519",
                      label = "519",
                      value = ""
  )}  
    if (2%in%input$checkClass){
      updateTextInput(session, "in532",
                      label = "532",
                      value = "c(1,2,3,4,5,6)"
      )}
    else if (!(2%in%input$checkClass)){
      updateTextInput(session, "in532",
                      label = "532",
                      value = ""
      )}

  })
  
  
observeEvent(input$action,{
    class <- sample(input$checkClass,1)
    classN <- ifelse(class==1,"519","532")
    s.list <- list(eval(parse(text=input$in519)),eval(parse(text=input$in532)))
    set <- sample(s.list[[as.numeric(class)]],1)
    ex <- sample(sets[sets$class==class & sets$set==set,3],1)
    id <- paste(class,set,ex,sep="_")
    
    updateTextInput(session, "goTo",
                    label =  "Choose a specific question:",
                    value = id
    )
    
    outfile0 <- normalizePath(file.path('./exs',paste(id,"_0.png",sep="")))
    outfile1 <- normalizePath(file.path('./exs',paste(id,"_1.png",sep="")))
    text <-  paste(classN,": Problem Set ",set, sep = "")
    
    output$myImage <- renderImage({
      list(src = outfile0,
           contentType = 'image/png',
           width = 800,
           # height = 300,
           alt = text)
    }, deleteFile = F)
    
    output$myImage1 <- renderImage({
      list(src = outfile1,
           contentType = 'image/png',
           width = 800,
           # height = 300,
           alt = text)
    }, deleteFile = F)
    
    output$Title <- renderText({text})
  })


observeEvent(input$goButton,{
      id <- input$goTo
      id.T <- strsplit(id, "_")[[1]]
      class <- id.T[1]
      classN <- ifelse(class==1,"519","532")
      set <- id.T[2]
  
  outfile0 <- normalizePath(file.path('./exs',paste(id,"_0.png",sep="")))
  outfile1 <- normalizePath(file.path('./exs',paste(id,"_1.png",sep="")))
  text <-  paste(classN,": Problem Set ",set, sep = "")
  
  output$myImage <- renderImage({
    list(src = outfile0,
         contentType = 'image/png',
         width = 800,
         # height = 300,
         alt = text)
  }, deleteFile = F)
  
  output$myImage1 <- renderImage({
    list(src = outfile1,
         contentType = 'image/png',
         width = 800,
         # height = 300,
         alt = text)
  }, deleteFile = F)
  
  output$Title <- renderText({text})
})
})



