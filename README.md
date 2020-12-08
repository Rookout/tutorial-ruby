# Rookout tutorial for debugging Ruby applictions

A sample app for debugging Ruby using [Rookout](https://rookout.com/).

## Prerequisites
1. ruby 2.7 or later.
2. rails 6.0.0 or later

## Setup
1. CLone the sample app from this repository.
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

## Usage
1. Log in to [Rookout](https://app.rookout.com/)
2. Select your tutorial-ruby server and add the source code.
3. Open the file `app/controllers/tasks_controller.rb` and set a breakpoint in line 35.
4. Browse to your [localhost](https://localhost:3000/) and add a todo item to the list.
5. Come back to Roookout and check the bottom messages pane. You'll see the snapshot you just added, as it was triggered by the handler of the web api when you added a todo.

## Want to learn more ?
- [Our website](https://rookout.com/) for more information
- [Our documentation](https://docs.rookout.com/) for more information
