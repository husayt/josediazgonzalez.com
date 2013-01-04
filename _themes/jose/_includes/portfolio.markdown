{% unless site.post_types.portfolio == empty %}
<div id="selected-work" class="section">
	<h2 class="section-title">Selected Work</h2>
	<a href="/portfolio/" class="btn-more">more &raquo;</a>
	<ul>
	{% for page in site.post_types.portfolio limit: 4 %}
		<li class="{% cycle 'odd', 'even' %}">
			<a href="/portfolio/{{ page.slug }}/">
				<img src="/images/portfolio/{{ page.slug }}/small.jpg" alt="{{ page.title }}" title="{{ page.title }}"/>
				<span>{{ page.title }}</span>
			</a>
		</li>
	{% endfor %}
	</ul>
</div><!-- end: #recent-work -->
{% endunless %}