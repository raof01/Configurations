# Setup UT Project for ES6
## Installation of Jasmine
1. Installation: search "Jasmine Test Explorer" in VS code, click "install" and then restart VS code.
2. create an empty folder, e.g. "my-proj"
2. cd my-proj
4. npm init -y
5. npm install jasmine-es6
6. node .\node_modules\jasmine-es6\bin\jasmine.js init
7. node .\node_modules\jasmine-es6\bin\jasmine.js examples
## Configuraiton for ES6 Support
1. Install babel npm packages:
```
npm install babel-core babel-preset-es2015 babel-preset-stage-0
```
2. Add .babelrc at the root of your code:
```
{
    "presets": [
        "es2015",
        "stage-0"
    ]
}
```
3. Change your jasmine.json by adding:
```
"helpers": [
    "../node_modules/babel-core/register.js"
  ]
```
4. jasmine.json may look like:
```
{
  "spec_dir": "spec",
  "spec_files": [
    "**/*.[sS]pec.js"
  ],
  "helpers": [
    "../node_modules/babel-core/register.js",
    "helpers/**/*.js"
  ]
}
```
