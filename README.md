![lines_0171.png](https://bitbucket.org/repo/RyexaR/images/3840594642-lines_0171.png)

#PRO-TO-TYPO

[Download sketches](https://bitbucket.org/ale2x72/prototypo/get/ab3ba313f876.zip)

____________________________________________________________________________________________________________________________________
##.:. GENERAL NOTES

Here's the repository with the definitions made during the Pro-To-Typo Processing workshop held by Alessio Erioli - Co-de-iT at RUFA [http://www.unirufa.it/]. There are also some extra to play with.
The workshop was focused on generative graphic and typography with Processing



____________________________________________________________________________________________________________________________________
##.:. SKECTH SUMMARY



______________________________

###. day 01


.

***d01_00_library_test***

preliminary sketch to test correct installation of all libraries. If a grey window of about 100x100 pixels appear and nothing else happens, everything is ok


***d01_01_class_begin***

first sketch - several introductory stuff, the current version draws with mouse


***d01_02_class_aclass***

classes and objects - let's define a class and a few methods (behaviors)


***d01_03_jitterbug***

Jitterbug - simple class example with cascade constructors and save as png with transparent bg


***d01_xx_easing***

motion easing - mouse wheel controls threshold value


***d01_xx_geomerative_basics***

geomerative library basics - extract text as shape, extract points from shape

***d01_xx_inside_outside_text***

 slight modification of the example provided by AmnonP5 - [Generative Typography](http://www.creativeapplications.net/processing/generative-typography-processing-tutorial/)

uses the text drawn to an offscreen PGraphics to determine what color and shape it will draw to each xy-coordinate on the main screen

***d01_xx_Object_basics***

object and classes basics

***d01_xx_Object_behaviors***

object basics + behaviors

***d01_xx_particles_advanced***

particles with brightness field influence

***d01_xx_trig_bounce***

some trigonometry basics for animation

***d01_xx_trig_sincurve***

some trigonometry basics - sinusoid and Lissajous curve

***d01_xx_vector_basics***

basic vector operations

***day01_xx_trig_adv***

playing with (not so) basic trigonometry

______________________________

###. day 02
.

***d02_01_class_bug***

the bug strikes back: class definition: fields, constructor, methods

***d02_02_class_bug_transp***

drawing and saving a png with transparent background

***d02_03_font_PDF***

font to pdf - visualize a random font and saves on request a pdf file

***d02_04_1_class_bug_pdf_text***

generative text using the bug class previously created - saves pdf when bugs are all 'dead'

***d02_04_class_bug_transp_text***

generative text using the bug class previously created - saves transparent png


______________________________

###. day 03
.

***d03_class_pointilisme***

pointilisme effect based on image sampling


***d03_class_pshape_img***

sample an image in grayscale range and draw closest lines network


***d03_class_pshape_svg***

sample svg file for a specific color and draw closest lines network - this sketch creates was used to create the logo above

***d03_DLA***

 DLA (Diffusion Limited Aggregation) process on logo
 
 *NOTE: the DLA agorithm is rough, sketchy and for sure can be implemented much better, but for the time being it works the way I want*


***d03_pshape_geomerative***

SVG importer example - uses a custom SVG importer class based on the geomerative library

***d03_pshape_mesh***

use of the mesh library by Lee Byron to generate a Voronoi pattern on a SVG file


***d03_pshape_physics***

SVG importer + Verlet physics 2D example - uses a custom SVG importer class based on the geomerative library

______________________________

###. extra
.

***Prototypo_cover***

 cover design with Geomerative library
 
 Method
 
 generates ws cover
 . convert text to shapes
 . sample shapes for points
 . adds random points throughout the page
 . creates connections (3 orders of varying thickness according to distance range)

Notes

. pdf export in this sketch is done "old school" and not through a PGraphics

______________________________


##.:. REQUIREMENTS

In order to run these sketches you will need the following libraries:

. [Toxiclibs](http://toxiclibs.org)
. [Geomerative](http://www.ricardmarxer.com/geomerative/)
. [Mesh by Lee Byron](http://leebyron.com/mesh/)

______________________________

##.:. REFERENCES

.[Generative Typography](http://www.creativeapplications.net/processing/generative-typography-processing-tutorial/)
.[Caligraft](http://www.caligraft.com)

______________________________

##.:. KNOWN BUGS

none so far


____________________________________________________________________________________________________________________________________

##.:. FUTURE IMPLEMENTATIONS

. some comments are in Italian only, English translation will be implemented over time
. some more examples will be added in the "extra" section