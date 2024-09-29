search_text = "ALLOWED_HOSTS = []"
replace_text ="ALLOWED_HOSTS = ['*']"
filepath=r'/home/websson/Django_Projects/django_project/settings.py'

with open(filepath, 'r') as file:
    data = file.read()
    data = data.replace(search_text, replace_text)

with open(filepath, 'w') as file:
    file.write(data)

echo "CSRF_TRUSTED_ORIGINS=['$DJANGO_CSRF_DOMAIN']" >> /home/websson/Django_Projects/django_project/settings.py
