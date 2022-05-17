"
I represent a mapping where an entity has a child entity contained.
The child entity is owned by the parent and will be deleted if the
parent is deleted.

If many is true (defaults to false) the value is a collection of 
children instead of a single child.
"
Class {
	#name : #XtChildMapping,
	#superclass : #XtLinkMapping,
	#category : #XTDB
}
