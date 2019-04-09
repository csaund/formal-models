# formal-models
home of the R application for Formal Models of Spring 2019 at U of G

server code is in `server.R`, ui code is in `ui.R`

Run app by going into `/app` and opening `ui.R` or `server.R` and hitting "Run App." This should run the app.

Run the tutorial by opening `/app/tutorial.Rmd` and hitting "Run Document"

# TODO
* Update and add questions to `tutorial.Rmd` to the questions site.
* **Visualizations** for the linear regression tutorials
* **Text** for linear regression tutorials
* Add an "introduction" tab (move tabs over so they actually make sense)
* maybe use the prediction section to actually make predictions using regression equation?
* maybe tab on how regression equation is derived? Using real math? 

## 9/4/19

### Hello, Ladies. 

I made a few big ol' updates to some things. 

#### Changes: 
* removing a lof of the movie and setup and stuff from `ui.R` and `server.R`. F that noise, where we're going, we don't need movie data
* added a data generation function that uses something from copula theory called 'complement.' I'm not sure how I feel about it has it creates a very narrow window (we almost certainly need to revisit this because I don't think our data is normally distributed), but it does allow for....
* added data inputs. So it's a simple X ~ Y (where I have X be age and Y be litres of irn bru drunk per month). Users can control correlation and number of sample points. 
* Added tutorial questions. The tutorial file is in `tutorial.Rmd` where there are also links to some example questions, and the documentation of how to use the `learnr` package that generates the Rmd. 

I discovered since `learnr` generates something that isn't quite an html, it cannot be embedded into a full shiny app (it actually is a shiny widget that creates a shiny app for itself.) 

there is a lot of fancy markdown we can do within this tutorial, but I don't think we could make it a sophisticated UI with tabs and stuff. That being said, I'm not an R markdown wizard. We could probably create a page like [this](https://bookdown.org/yihui/rmarkdown/learnr-shiny.html).

Because data generation is a function, the same data can be used all throughout the server section, so if you use that data it will be the same as what's displayed in the original plot.

Also, the other tabs are nothing right now, feel free to change them as you see fit. I mean really change whatever you like, we have *vErSiOn CoNtRoL* so nothing can hurt us.


### *XOXO* Caro