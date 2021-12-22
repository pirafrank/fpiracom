{% assign sorted_certs = site.data.cv.certificates.certificates | sort: 'date' | reverse %}
{% for cert in sorted_certs %}
- [{{ cert.title }}]({{ site.baseurl | append: '/assets/files/certs/' | append: cert.file }}) ({{ cert.date | date: "%B %Y"}}){% endfor %}

Badges are also available on [Credly]({{ site.data.social.credly.url }}).
