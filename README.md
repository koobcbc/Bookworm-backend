# Project-4

# Description

-   


# Project Links 
## Project URL
- []()

## Git Repos
- [frontend git]() 
- [backend git]()

# Wireframs/Architecture
- [WireFrame](https://www.figma.com/file/3PGHU4ez2A2nW7BCGAuUYr/icecream-app?node-id=12%3A4)
- [React Architecture](https://imgur.com/vyTQGPH)

# Time Priority Matrix/Chart
  
| Component | Priority | Estimated Time | Time Invetsted | Actual Time |
| --- | :---: |  :---: | :---: | :---: |
| Create Model | E | 1hr | 3hrs | 3hrs |
| Create Controller | E | 2 hour | 4hrs | 4hrs |
| Setup Server | E | .5hr| .5hrs | .5hrs |
| Set up Conections  | E | .5hrs| .5hrs | .5hrs |
| create Seed File  | M | 2hrs | 4hrs | 4hrs |
| Research  | E | 2hrs| 4hrs | 4hrs |
| Deployment  | H | 2hrs| 2hrs | 2hrs |
| Total | H | 10hrs | 18hrs | 18hrs |

| Component | Priority | Estimated Time | Time Invetsted | Actual Time |
| --- | :---: |  :---: | :---: | :---: |
| Create react app and components| H | .5hr| .5 hr | .5 hr |
| Install packages and Set up React Routing | H | .5hr| .5 hr | .5hr |
| Make APIcall from App | H | .5hr| .5hr | .5hr |
| Set up the layout components (Header, NavBar, Footer) | H | .5hr | 1hr | 1hr |
| Home component | H | 1hr| .5hr | .5hr |
| New order component | H | 2hr| 2hr | 2hr |
| Functionality of order form | H | 5hr| 6hr | 6hr |
| make delete / filter functionality in Past Order | H | 2.5hrs| 6hr | 6hr |
| Basic Styling for nav, footer, about page | H | 2hrs| 2hr | 2hr |
| Basic Styling for main | H | 10hrs| 4hrs | 4hrs |
| Total | H | 26.5hrs| 23hrs | 23hrs | 

#### MVP
- Create mongoDB using mongoose
- Use the api created by mongoDB
- Create components
- Create Functionality for reading, adding, deleting, and updating
- Allow user to input their selections for order
- Allow user to navigate to past orders
#### PostMVP
- Additional Styling and animations
- Allow users to search by their name

## Components description
- Header
  - Shared component that sits at the top of the page and contains site title/tagline/logo
- Nav
  Shared component right below Header, contains links to the components Home, New Order, and Past-Orders
- Home
  - Simple landing page with graphic/tagline/eetc.
- New Order
   - Page with form that allows you to fill out your order. Options for names, toppings, cone, bowl,etc.
- Past Orders
   - The past orders will all be stored in the backend. This page will render a list of past orders with name and date. Clicking on an order will take you to an Order page.
- Order
  - Page that contains all the details of a specifiv past order.
- About
  - This will be the "Team Page" with photos and descriptions of everyone that worked on the project
- Footer
  - Shared component with copyright info etc.


# Backend Description
- models/Schemas. (Alex, Joe)

- The Milkshakes Schema will contain keys with the value of flavor, toppings, size and price. The flavors, toppings and size values will be set to String and the value of price will be set to Number.
- The Ice Cream Schema will contain keys that hold values of flavor, toppings, size that will all be set to strings. In addition to those we will also throw in a price value set to a number.
- The Menu schema will hold a list of our menu items. The schema will contain values of flavor, toppings, holder and size, so that the frontend can pull that info and set up a menu in the app where users can see what options they have to choose from.
- We will create three seperate controllers. One will contain the Schema and model for the milkshakes, the other holds the Ice Cream Schema and model, and the menu will function with the menu schema and model.

# Additional libraries
- Axios
- React
- Node
- Express

# Code Snippet 
- project code 

```

```
