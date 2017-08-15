How to build the PSP Pokemon editor

# Introduction

This covers my process of creating a PSP Pokemon Save Editor for Pokemon Fire Red. I’m sticking with Red at the moment, maybe I’ll cover more GBA games in the future. 

Note: I’m using the USA version of Pokemon Fire Red. I have not tested with other regions.

First I played about 2 hours of Pokemon. I got my first two Pokemon and evolved to Ivysaur and Metapod. 

My bag contained Antidote x2 and Poke Ball x 16. This is what I used as my baseline to search for in the save file.

As we are starting completely from scratch, I’m using HEX editing to manipulate the save files. I run OS X and decided to use HEX Fiend as it came up first on bing.

Since we are editing save files from the PSP I’ll be using GPsp Kai emulator which probably has a different save format that other emulators (VBA). So development and debugging will only work with this emulator.

Lets start..

# Finding the items

First on my list is to have the ability to edit how many items at each slot in the bag there are. For example, currently I have 2 Antidotes in my bag. I want to have 99, so let’s figure out how to get 99.

I took the save file from my PSP Go and make a couple of back ups on my desktop. I won’t start with developing on the PSP app yet. I want to have a proof of concept that what I’m doing works on a computer first. Faster debugging.

So I open up sublime, HEX Fiend and searched the internet for a Pokemon Fire Red (FR for now on) item HEX values. I don’t want to spend finding HEX values myself, I know it’s been done before.

So I found this resource: 
