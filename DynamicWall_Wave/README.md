# MoMath DynamicWall Wave-collision

## Overview

This Wave illustration is made for the DynamicWall at MoMath NYC. 
https://github.com/momath/dynamic-wall

Dynamic Wall is the huge sculpture-esque exhibit you saw on the right hand side as you entered the Museum. 
It has 128 metal slats, the depth of which are individually controllable on both the top and the bottom. 
Use the surface or creases between the slabs to create interesting and mathematically-illuminating effects. 
This project uses the programming language Processing.

This visulization shows 2 sine waves coming from either side and their interaction as they collide in the centre. It demonstrate properties of 
wave interference as they intersect with each other. Viewers can learn such properties like how 

## Install

### Installation
Follow the instruction on https://github.com/momath/math-square. 
Place js file inside the /behs folder. 


## Development

### Finding Regression between user
Linear regresssion is found using the least square method and a line is then plotted by finding the min and max of x point. With these 2 x coordinates, we can then calculate the 2 corresponding y and then plot a line across these 2 coordinates. 

### Target Line
The target line is a line where it crossed x @ 0 and x @ max dimension of the floor. y of these 2 coordinates are randomly generated.

### Matching user regression and line
The game is won when the slope and intercept of the user regression and is within a certain threshold of the target line's respective slope and intercept. Once this is within range, a new target is drawn. 



