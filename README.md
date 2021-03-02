# Rookout tutorial for debugging Ruby applictions

A sample app for debugging Ruby using [Rookout](https://rookout.com/).

## Prerequisites
1. ruby 2.7 or later.
2. rails 6.0.0 or later

## Setup
1. Clone the sample app from this repository.
```bash
git clone https://github.com/Rookout/tutorial-ruby.git
cd tutorial-ruby
```

2. Set your Rookout token as an environment variable (for Windows, use ***set*** instead of **export**)
```bash
export ROOKOUT_TOKEN=[Your Rookout Token]
```

3. Run the app:
```bash
bundle install
rails server
```

the app will now run on `https://localhost:3000/`

- Optional - Run the app using Docker:

```bash
docker run -p 3000:3000 -e ROOKOUT_TOKEN=$ROOKOUT_TOKEN rookout/tutorial-ruby
```

## Usage

- Log in to [the Rookout IDE][rookout-app-url].
- Add the source code according to the instructions using the left pane **Source View**

    <details>
    <summary>More details</summary>
    <p>
    
    #### Adding source code
    
    1. Click on Add source
    1. Choose source control
        - Github
            - Click on Connect
            - Authorize O-Auth
            - Fill `Repository Owner`
            - Click `Repository` and choose from the dropdown menu
            - Click Next
            - Choose the desired branch
            - Click View Repository
        - Local FileSystem - Server
            - Click on Setup Server
            - Choose a supported HTTP Server
            - Follow the on-screen instructions
    </p>
    </details>
    
    
- Open the file `app/controllers/tasks_controller.rb`
- Add a Breakpoint next to line number 35 by clicking next the the line number in the file viewer
- The Breakpoint should turn solid purple, indicating that it has been set successfully and that it is active.
    - If this is not the case, [click here](https://docs.rookout.com/docs/breakpoints-status.html) to see how to fix that
- Go the the app webpage http://localhost:3000/ and add a todo in order to trigger the Breakpoint
- Check the bottom pane **Messages** and you'll see the snapshot you just added, as it was triggered by the handler of the web api when you added a todo

## Common Pitfalls

- Breakpoint status is pending (hollow with purple outline) -- Connection to the app was not able to be established. Make sure that you inserted the Rookout Token in the right place and that the SDK was properly installed.
- Breakpoing status is disabled (solid grey) -- The breakpoint was disabled from collecting more data due to the limits being hit.
- Brekapoint error -- something went wrong. Check the breakpoint status to get more information on the error type, and for more information go to our [breakpoint status guide](https://docs.rookout.com/docs/breakpoints-status/).

## Want to learn more ?

- [Our website](https://rookout.com/) for more information
- [Our documentation](https://docs.rookout.com/) for more information
- [our deployment examples](https://docs.rookout.com/docs/deployment-examples.html) for platform-specific integration examples
