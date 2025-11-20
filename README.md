# spirit's (sprt_) CET Libraries

This repo contains useful lua libraries for use with CyberEngineTweaks.

## Usage
To use all libraries simply put the "libs" folder into your CET mods folder (where your init.lua is). 

If you wish to change the directory path you will need to adjust the "require()" method paths accordingly for modules that require other modules.

### logger
requires: json

Logs any object / message to both mod log and console, with an optional parameter to exclusively log to the mod log.
Prefix can be customized to identify your mod and supports info, warning and error level messages. 

### json
requires: logger

Serializes strings to tables directly and vise versa. Supports compact and pretty print. 

## Licensing 
All libraries provided in this repo are MIT licensed. 
