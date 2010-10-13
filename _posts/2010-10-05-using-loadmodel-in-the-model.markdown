---
  title: Using loadModel() in the Model
  category: Models
  tags:
    - cakephp
    - code
    - model
    - loadmodel
  layout: post
---

In IRC, a frequently asked question is how to use unrelated models in both controllers and models.

The standard answer for controllers is to use `Controller::loadModel()` in the Controller, as this can be used in combination with `Controller::$persistModel`, as well as other features, to quickly cache the model for faster loading later. It's a pretty neat trick.

In the Model, however, the answer has been to use `ClassRegistry::init()` to load models. It works, but it returns an instance of the model, where most developers might expect it to create a class variable like `Controller::loadModel()` does. Because it returns an instance, it also uses more memory and developers use it in all sorts of crazy ways. It's a mess.

Last night, someone asked about what they should use in a Model, so instead of repeating the same tired answers, I came up with a `Model::loadModel()` method of my own.

<script src="http://gist.github.com/611033.js?file=app_model.php"></script>

I think it's pretty nifty. Usage is simple:

{% highlight php %}
<?php
class User extends AppModel {
    
    function getPosts($limit = 10) {
        $this->loadModel('Post');
        return $this->Post->find('all', array('limit' => $limit));
    }

    function getTags($limit = 10) {
        // Tag is really just an alias for a Category, we can then 
        // load up separate instances of the model for things like
        // attaching behaviors etc.
        $this->loadModel('Tag', 'Category');
        return $this->Category->find('all', array('limit' => $limit));
    }

}
?>
{% endhighlight %}

Of course, once you call `Model::loadModel()`, the loaded model is available for the length of the entire request, so long as it is called from that same initial model. It would be useful in cases where, for example, one needs to call an internal, unrelated Api Model repeatedly across multiple model methods.

Calling `Model::loadModel()` multiple times doesn't even create a new instance, merely clears it's internal state.

Feel free to use and abuse this. It is currently untested, and would do well to go into a behavior.