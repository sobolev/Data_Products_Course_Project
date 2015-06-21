library(shiny)
shinyUI(fluidPage(
    titlePanel("Mortality Calculator"),
    sidebarLayout(
        sidebarPanel(
            helpText("Given your current age this app will reveal your expected lifetime.  Additionally,
                     given a target age it will tell you the probability of living that long from your current
                     age as well as a plot of probability of living at each age in between."),            
            br(),            
            
                        
            sliderInput("slider_currage",
                        label = h6("Choose current age in years:"),
                        min = 0, max = 119, value = 1),
            
            br(),            
            sliderInput("slider_years",
                        label = h6("Choose the age to which you would like to live in years:"),
                        min = 0, max = 119, value = 1),
            br(),
            selectInput("select_gender",
                        label = h6("Choose gender:"),
                        choices = list("Male" = 1,
                                       "Female" = 2),
                        selected = 1 
            ), 
            br(),
            br(),            
            actionButton("action_Calc", label = "Submit")        
            ),
        mainPanel(
            tabsetPanel(
                tabPanel("Output",
                         p(h5("Your entered values:")),
                         textOutput("text_currage"),
                         textOutput("text_years"),
                         textOutput("text_gender"),
                         br(),
                         p(h5("Calculated values:")),
                         textOutput("text_exp_life"),
                         textOutput("text_prob"),
                         plotOutput("plot_lives")
                ),
                tabPanel("Documentation",
                         p(h4("Mortality Calculator:")),
                         br(),
                         helpText("This application calculates your expected lifetime given your current age based on
                                  the Social Security Administration's 2010 life table.  It will also tell you
                                  the probability of living to a given target age from your current age."),
                         HTML("<u><b>Method of Calculation: </b></u>
                              <br> <br>
                              <br>
                              Based upon the life table located at: 
                              "),
                         helpText(a("SSN Mortality Table",href="http://www.ssa.gov/oact/STATS/table4c6.html",target="_blank")),
                         
                         helpText("The application looks up your current age based on your gender selection from
                                  the table and returns the expected years of remaining life and adds this
                                  result to your current age to determine your expected lifetime.  It then uses the 
                                  target age to look up the remaining lives at the target age.  It subtracts the
                                  remaining lives from the current lives (the ones at your current age) to determine
                                  the number of deaths between the current age and target age.  The number of deaths
                                  divided by the current lives is the probability of dying before you get to target age. 
                                  The complement is the probability of living until the target age. Additionally, 
                                  a plot is generated showing the probability of survival between the current age and 
                                  target age at each year in between.  This is calculated by dividing the lives
                                  at each yearly increment by the current lives and taking the complement."),
                         helpText("If you choose a target age less than your current age the application assumes
                                  the target age is equal to the current age.")
                         )
                         )
                         )
                         )))