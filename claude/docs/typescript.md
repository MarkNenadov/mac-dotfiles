# typescript.MD

## Basic Principles

* Take the time to get the typing right from the start (be hesitant to use "any")

## Typescript/React/Node/Web Projects

* Prefer TailwindCSS for styling
* Prefer Next.JS
* Prefer bun over npm/yarn

## React: Organization

* One exported Component per file (private sub components are fine)
* Create a folder structure that groups things, avoid a rigid "one-folder-per-component" scheme

## React: Naming and Formatting

* Component file names should be PascalCase
* Avoid using dom prop names (ie. style, className, etc.)
* Ordinarily split Component instantiations across lines if they have 3 or more props
* When calling a component, keep it on one line if it fits well. Otherwise utilize and a new line and an indenty for each prop

## React: General

* De-structure obsessively (but maybe don't go overboard)
* Ordinarily de-structure your props in the component signature
* Keep your state as low as you can.