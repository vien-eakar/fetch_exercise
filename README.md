# fetch_exercise
### Structure Explanation
I have adopted the `MVVM` (Model-View-ViewModel) architecture to address this problem. Instead of organizing the source code by folders such as `Model`, `ViewModel`, etc.,
I chose to structure it by `Screen`. This approach facilitates easier maintenance and updates.
Additionally, I created a `Common.swift` file to define all common functionalities required in the project.
For larger projects, this can be divided into a Common folder, with each common functionality split into individual classes as necessary.
I also established an API folder to house all implementations related to API calls.

### Coding Explanation
#### Data Structure
To fetch data from the API, I used the `Codable` protocol to decode the data. I defined only the necessary fields in the struct. For the meal detail API data, instead of listing all `strIngredient1` ... `strIngredient20` and `strMeasure1` ... `strMeasure20` separately, I created arrays of String to store the ingredients and measures. Then, I used the init(from decoder: Decoder) throws method to decode all the required data efficiently.

#### Fetch Data
I utilized `URLSession.shared.data` with await to fetch data from the server. After fetching the data, I decoded it and assigned it to properties in the `ViewModel` to display on the View.

#### UI
I used `NavigationStack` and a `List` with `NavigationLink` to display meals and navigate to the meal details. I also implemented a `Toolbar` to add a sorting function. By default, the list is sorted alphabetically, but it can also be sorted by meal ID. Additionally, I included `Animations` when switching the sort type from alphabetical to by ID.
I utilized `AsyncImage` to load and display images of meals.


### Note
In my experience, I have worked for a Japanese company for approximately four years, during which I predominantly used `Xcode` with `UIKit` to develop applications.
While I haven't yet worked on a real `SwiftUI` project, I am actively studying it and am excited about its powerful capabilities.

I would greatly appreciate the opportunity to work with your team!

