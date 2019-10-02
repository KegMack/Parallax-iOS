# Parallax-iOS

This is intended as an easy-to-use parallax view controller which can be added into an existing project.

This will allow you to use a custom background image and content view controller. 
The background image will be automatically scaled to the specified ratio and placed behind the content view.
The content view will be automatically placed in a scrollView.



## How to implement

It consists of just a single file __parallax.swift__

Once the above file is in the project, use the initializer to create an instance of the class.

```ParallaxViewController(parallaxRatio: Double, image: UIImage, contentViewController: UIViewController)```

_parallaxRatio_ is the ratio of the scrolling background image height to screen height.  
Use a higher number if you desire a faster parallax affect.
It is an optional parameter, and will default to 1.4 (must be greater than 1.0 or it will go to default)

_image_ is the background image you would like to use

_contentViewController_ is the view controller which you would like to display.
Use transparent background on the contentViewController's view, or at least something semi-transparent.

