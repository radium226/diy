#!/usr/bin/env python

import FreeCAD as App
import FreeCADGui as Gui

import Part

from collections import namedtuple


LENGTH = 700
WIDTH = 500
HEIGHT = 80


DECK_HEIGHT = 18

Size = namedtuple("Size", ["Length", "Width", "Height"])

Position = namedtuple("Position", ["X", "Y", "Z"])

Rotation = namedtuple("Rotation", ["X", "Y", "Z"])

Placement = namedtuple("Placement", ["Position", "Rotation"])


def addDeck(label, size):
    document = App.ActiveDocument
    boxPart = document.addObject("Part::Box","Box")
    boxPart.Label = label
    boxPart.Length = size.Length
    boxPart.Width = size.Width
    boxPart.Height = size.Height
    boxPart.Placement = App.Placement(
        App.Vector(0, 0, 0), 
        App.Rotation(
            App.Vector(0,0,1), 0
        )
    )
    return boxPart


#def rotateDeck(label, rotation, axis):
	


def generate():
    document = App.newDocument("ChangingTableDocument")
    
    bottomBoxPart = addDeck("BottomDeck", Size(LENGTH, WIDTH + 2 * DECK_HEIGHT, DECK_HEIGHT))

    leftBoxPart = addDeck("LeftDeck", Size(LENGTH, HEIGHT, DECK_HEIGHT))
    leftBoxPart.Placement = App.Placement(
        App.Vector(0, DECK_HEIGHT, DECK_HEIGHT), 
        App.Rotation(
          App.Vector(1, 0, 0), 
          90
        )
    )

    rightBoxPart = addDeck("RightDeck", Size(LENGTH, HEIGHT, DECK_HEIGHT))
    rightBoxPart.Placement = App.Placement(
        App.Vector(0, WIDTH + 2 * DECK_HEIGHT, DECK_HEIGHT), 
        App.Rotation(
          App.Vector(1, 0, 0), 
          90
        )
    )

    rearBoxPart = addDeck("RearDeck", Size(HEIGHT, WIDTH, DECK_HEIGHT))
    rearBoxPart.Placement = App.Placement(
        App.Vector(0, WIDTH + DECK_HEIGHT, DECK_HEIGHT), 
        App.Rotation(
          App.Vector(1, 0, 1), 
          180
        )
    )

    document.recompute()
    #document.saveAs("ChangingTable2.FCStd")


#if __name__ == "__main__":
generate()