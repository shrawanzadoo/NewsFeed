# NewsFeed

NewsFeed app (iOS)

## Prerequisites

* Xcode

## Getting Started

1. Clone repo
2. Open in Xcode using the xcworkspace file

##

News Feed combines data from three API calls:
- http://jsonplaceholder.typicode.com/comments
- http://jsonplaceholder.typicode.com/posts
- http://jsonplaceholder.typicode.com/users
 
- The app displays a news feed, like a social media application with users and comments assosiated with the respective posts.
- MVP architecture is used
- Repository pattern is used for the business logic
- All dependecies are injected and can be mocked
- Data is stored using core data
- Unit tests are written for all business logic and data storage
- Snapshot tests added for UI testing and aiding TDD
- Custom networking layer implemented
- Project structured into Data, Domain and UI layer
- Uses reactive and functional aspects and adheres to the SOLID principles

#### Tests
**NB** Make sure you have the iPhone 11 Pro selected as the target when running the tests otherwise they will fail.

Unit tests can be found in the `News FeedTests` folder.

Snapshot tests can be found in the `NewsFeedSnapshotTests` folder.

Run the tests by clicking the play icon next to each test class.

If you've made any UI changes then you need to update the snapshot tests:
1. Click the scheme button in the top left corner of XCode.
2. Select "Edit Scheme". This should open a pop up. 
3. Select the "Run" tab and tick the environment variable for `RECORD_MODE`.
4. Run the tests that need updating. They'll still fail but the error should say that they've been run in record mode and the results recorded.
5. Untick the `RECORD_MODE` variable in the scheme again.
6. Run the updated tests again. They should now pass.

## Troubleshooting

### XCode fails to open the project properly
* Make sure you've run `pod install` before opening.
* Make sure you've opened the workspace file and not the project file.
* Make sure you have at least v11 of XCode.

### The iOS snapshot tests fail
* Make sure to use the iPhone 11 Pro simulator. The tests are set to a screen size so if you use a different device they fail.

