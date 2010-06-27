<div id="popular-tags" class="section">	
	<h2 class="section-title">Related Tags</h2>
	<ul>
		{% for tag in page.related %}
			<li><a href="/tags/{{ tag }}">{{ tag }}</a></li>
		{% endfor %}
	</ul>
</div>