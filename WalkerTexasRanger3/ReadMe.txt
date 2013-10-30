This project shows how to walk through an XML document tree and recreate the structure with linked objects.

MyData is an object that has a name, dataValue, and children. Child objects can be added to the array of the object.

Version 1 uses a persistent MyData object in the MainViewController. It's value changes as the XML is parsed. Likewise, the "currentElementValue" mutable string is persistent and changes over time. This design is required in order to handle the found characters method. Found characters does not always finish in one shot, it may return multiple times, so the string must live and be appended.

When the xml tree is walked, didStartElement will create a COPY of the currentObject. MyData class implements the NSCopying protocol in order to be able to create copies of itself. The method that you implement should copy all the primitive values in the object; but not necessarily if you define a valid copy as having different or empty values from it's actual source. Versions 2 and 3 of this project do not use the COPY protocol.

As the xml is walked, 2 main functions occur:
	1. The tree structure is created. A MyData object is created as the root item, and then objects are added to it's children array, and likewise those children.
	2. Simultaneously a "flat" array is stored of the last element that was added to the tree. In order to be able to "jump up" in the tree structure, we must have a handle for the previous objects that were added.
	
When an element is ended, the string value is added to the flat array's last item. The handle for the currently added item (last item of flat array) is the same memory address as the tree-structure item. Then the flat array's last item is removed, thus exposing the parent object.

Version 2 shows how to make a new item each time instead of reusing a persistent item.
Version 3 shows how to detect xml items and create either new item lists or partial tree arrays based on element names.

Hopefully this will shed some light on XML tree structuring. Most other examples on the web have highly customized tree parsing with multiple IF-ELSE or SWITCH statements to break XML out into many different objects. Hopefully you can see how it would be easy to implement a new class of your own to target sections of XML into different object type classes.

Chris Paveglio
www.paveglio.com
2013.10.10