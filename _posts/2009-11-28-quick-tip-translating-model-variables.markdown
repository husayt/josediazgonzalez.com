---
  title: Quick Tip - Translating Model Variables
  category: Internationalization
  tags:
    - cakephp
    - internationalization
    - translation
    - models
  layout: post
---

In the latest [Marcy Avenue commits](http://github.com/josegonzalez/marcyavenue/), I've been working on some internationalization. Well, I've been working on standardizing model validation messages. I've got a pretty good and standardized set of them, so translating those messages into other languages shouldn't be too difficult.

I thought I had a pretty good idea as to how to internationalize those messages. Usually, you do the following to any string in CakePHP:

{% highlight php %}
<?php __('encapsulate string in this convenient function'); ?>
{% endhighlight %}

And then run the following shell command:

{% highlight bash %}
cake i18n initdb
cake i18n extract
{% endhighlight %}

Or something like that. That should somehow generate .pot files, which is where CakePHP will grab translations. I'll write a better guide in the coming weeks, as that is beyond the scope of this post.

Anyways, I did the following to my rules:

{% highlight php %}
<?php
class Category extends AppModel {
	var $name = 'Category';
	function __construct() {
		$this->validate = array(
			'title' => array(
				'notempty' => array(
					'rule' => array('notempty'),
					'message' => __('cannot be left empty', true)
				),
			),
		);
		$this->visibilities = array(
			'published' => __('Published', true),
			'private' => __('Private', true),
			'password' => __('Password Protected', true),
		);
	}
}
?>
{% endhighlight %}

*Don't do that! It will break the entire application!* The error message will be something like the following (it won't give you a damned idea as to what the hell is happening either, which is annoying lol):

{% highlight bash %}
Fatal error: Call to a member function trigger() on a non-object in cake/libs/model/model.php on line 2057
{% endhighlight %}

You forgot to call the parent Model::__construct() function, as well as all the parameters that the Model constructor takes. Do the following:

{% highlight php %}
<?php
class Category extends AppModel {
	var $name = 'Category';
	function __construct($id = false, $table = null, $ds = null) {
		parent::__construct($id, $table, $ds);
		$this->validate = array(
			'title' => array(
				'notempty' => array(
					'rule' => array('notempty'),
					'message' => __('cannot be left empty', true)
				),
			),
		);
		$this->visibilities = array(
			'published' => __('Published', true),
			'private' => __('Private', true),
			'password' => __('Password Protected', true),
		);
	}
}
?>
{% endhighlight %}

Note that you do not need to do 

{% highlight php %}
var $validate = array();
{% endhighlight %}

before the constructor. You can also place any other variables that you would like to translate in the constructor, like I do with my $visibilities variable. Then you'll no longer get that silly `trigger()` error message. And your app will work again. Hurray! Whoagies unite!

_Note: For the record, I'm targeting a French translation of Marcy Avenue first, followed by Spanish, simply so I can practice French._