{% assign certifications = site.data.cv.certifications %}
{% for cert in certifications %}
{% assign da = cert.dateAchieved | date: "%B, %Y" %}
{% if cert.dateExpires != "" %}{% assign dexp = cert.dateExpires | date: "%B, %Y" | prepend: ' Expires in ' %}
{% else %}{% assign dexp = "" %}{% endif %}
{% if cert.code != "" %}{% assign code = cert.code | prepend: " \(" | append: "\)" %}
{% else %}{% assign code = "" %}{% endif %}
{% if cert.url != "" %}
- [{{ cert.name }}{{code}}]({{ cert.url }})<br>Achieved in {{ da }}.{{ dexp }}
{% else %}
- {{ cert.name }}{{code}}<br>Achieved in {{ da }}.{{ dexp }}
{% endif %}
{% endfor %}

Badges are also available on [Credly]({{ site.data.social.credly.url }}).
