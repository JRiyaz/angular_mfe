# AngularMfe

This project was generated with [Angular CLI](https://github.com/angular/angular-cli) version 14.2.5.

## Development server

Run `ng serve` for a dev server. Navigate to `http://localhost:4200/`. The application will automatically reload if you change any of the source files.

## Code scaffolding

Run `ng generate component component-name` to generate a new component. You can also use `ng generate directive|pipe|service|class|guard|interface|enum|module`.

## Build

Run `ng build` to build the project. The build artifacts will be stored in the `dist/` directory.

## Running unit tests

Run `ng test` to execute the unit tests via [Karma](https://karma-runner.github.io).

## Running end-to-end tests

Run `ng e2e` to execute the end-to-end tests via a platform of your choice. To use this command, you need to first add a package that implements end-to-end testing capabilities.

## Further help

To get more help on the Angular CLI use `ng help` or go check out the [Angular CLI Overview and Command Reference](https://angular.io/cli) page.

## Add an Application

ng g application sre --routing --style=css

This creates a new application under projects folder and adds entry point in angular.json

## Link Git project

cd projects/sre

git init

git add .

git commit -a -m 'Initial commit'

git remote add origin git@github.com:JRiyaz/angular_mfe_user.git

## Update submodule

cd ui_monorepo

git submodule add --name shell git@github.com:JRiyaz/angular_mfe_shell.git projects/shell

## Add module federation configuration

ng add @angular-architects/module-federation --project sre --port 7000

## Move frontend related files to `ui` folder

### Move angular files to `ui` folder

`sre/* => sre/ui/*`

### Update the location

- `/sre` to `/sre/ui` in angular.json
- update `extends` property path in (sre) tsconfig.app.json
  - `"extends": "../../tsconfig.json",` => `"extends": "../../../tsconfig.json",`
- update `extends` property path in (sre) tsconfig.spec.json

## Update webpack.config.json

File: projects/sre/ui/webpack.config.js

- Update `sharedMappings` and `ModuleFederationPlugin` in webpack.config.js
  - Update root tsconfig file path - section: `sharedMappings.register()`
    - `path.join(__dirname, '../../tsconfig.json'), []);` => `path.join(__dirname, '../../../tsconfig.json'), ['ui']);`
  - Add the custom file name config - section: `output: {}`
    - `chunkFilename: '[name]-[contenthash].js'`
  - Update ModuleFederationPlugin config - section: `plugins: [ new ModuleFederationPlugin()]`

## Add Apache config

File: [apache/jiva.zeomega.org.conf]

`RewriteRule "^/user/(.\*)$" "http://host.docker.internal:7000/user/$1" [P,QSA,L]`

## Create Docker files

cd projects/sre/build/dockerfiles

### Create docker files for new MFE

- build/dockerfiles/NgDockerfile
- build/dockerfiles/NgDockerfile.dev

### Update docker-compose-dev.yml

File: docker-compose-dev.yml
section: services

```yml
services:
  sre:
    stdin_open: true
    build:
      dockerfile: ./projects/sre/build/dockerfiles/NgDockerfile.dev
      context: .
    volumes:
      - /app/node_modules
      - .:/app
    ports:
      - "7000:7000"
```

## update husky for prettier

cd projects/qi && git config core.hooksPath ../../.husky
cd ../..

1. ng new angular_mfe --create-application false
2. cd angular_mfe/
3. npm i bootstrap@5.2.2, npm install animate.css --save
   make the following changes in angular.json file
   "styles": [
   "projects/shell/src/styles.css",
   "node_modules/bootstrap/dist/css/bootstrap.min.css"
   ],
   "scripts": [
   "node_modules/bootstrap/dist/js/bootstrap.min.js"
   ],

4. ng g app shell
5. ng add @angular-architects/module-federation --project shell --type dynamic-host/host --port 4200
6. ng g app flight
7. ng add @angular-architects/module-federation --project flight --type remote --port 4201

8. ng generate module app --routing --flat (--flat does not create folder, --routing with router file)
9. ng g c foo --module app --project shell (OR) ng g c app/foo --project shell (inside app module)
