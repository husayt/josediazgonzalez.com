---
  title:       "Commentable Behavior"
  date:        2009-06-15 00:00
  description: Commentable Behavior for CakePHP 1.2
  category:    Behaviors
  tags:
    - cakephp
    - commentable
    - behaviors
    - github
    - quicktip
    - cakephp 1.2
  comments:    true
  sharing:     false
  published:   true
  layout:      post
---

The following should get you up and running with Commentable Behavior. Note that I've only tested it with a "Post" model, but it should work fine otherwise.

Follow the instructions at the following repo and you'll be up and running in no time :)

[http://github.com/josegonzalez/cakephp-commentable-behavior](http://github.com/josegonzalez/cakephp-commentable-behavior)

To use the behavior, include it in your model. Please note that if it is not using the standard "Post" model, then you'll have to configure the options array. Take a look at the behavior above for the types of options it will take.
Model Class:

``` lang:php
class Post extends AppModel {
    public $actsAs = array('Commentable');
}
```

You don't need to create a model for 'Comment', unless you plan on doing something special. By default, CakePHP will build a model for tables that don't explicitly have them created. If you name your Comment table something other than comments, however, or would like to do some extra validation/have cool model methods, go right ahead and create a model called comment.php. Otherwise, keep reading.

You'll also need a SQL table to store all your comments. The following will work with the defaults:
SQL:

``` lang:sql
CREATE TABLE `comments` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`model_name` varchar(128) NOT NULL,
	`foreign_id` int(11) NOT NULL,
	`name` varchar(255) NOT NULL,
	`email` varchar(255) NOT NULL,
	`body` text,
	`created` datetime DEFAULT NULL,
	`modified` datetime DEFAULT NULL,
	PRIMARY KEY  (`id`)
)
```

You'll need a controller action such as the following:
Controller Class:

``` lang:php
class PostsController extends AppController {
	public function comment($id = null) {
		$post = $this->Post->findById($id);

		if (empty($post)) {
			throw new InvalidArgumentException("Invalid post")
		}

		if (!empty($this->data['Comment'])) {
			if ($this->Post->createComment($id, $this->data)){
				$this->Session->setFlash(__('Post was commented on', true), 'messages/success');
				$this->redirect(array('action' => 'view', $id), 200, true);
			} else {
				$this->Session->setFlash(__('Post could not be commented on. Perhaps you left a field empty?', true), 'messages/error');
				$this->redirect(array('action' => 'view', $id), 400, true);
			}
		}

		if (empty($this->data)) {
			$this->data = $this->Post->read(null, $id);
		}
	}
}
```

And this view will work wonders when posting to the preceding action
View file:

``` post.ctp lang:php
<h2><?php __('Post a Comment');?></h2>
<?php echo $form->create('Post', array('url' => $this->here));?>
	<fieldset>
		<legend><?php __('Add Comment');?></legend>
		<?php
			echo $form->input('Post.id');
			echo $form->input('Comment.name');
			echo $form->input('Comment.email');
			echo $form->input('Comment.body');
		?>
	</fieldset>
<?php echo $form->end('Submit');?>
```

I'm 95% sure that's all that I needed to get everything up and running. If there are any bugs in my code anywhere, drop me a line. I'm also interested in hearing about potential enhancements to the behavior, as it is very basic and doesn't include stuff I'd like such as field validation or associating the comment with a logged in user. Have fun!
