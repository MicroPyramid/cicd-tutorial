from ubuntu:latest

RUN apt-get update && apt-get install -y python-pip python-dev uwsgi nginx uwsgi-plugin-python
COPY ./ /home/sample_proj/
RUN rm /etc/nginx/sites-available/default
RUN ls /home/sample_proj/
RUN cp /home/sample_proj/confs/nginx.conf /etc/nginx/sites-available/sample.conf
RUN ln -s /etc/nginx/sites-available/sample.conf /etc/nginx/sites-enabled/sample.conf
RUN pip install -r /home/sample_proj/requirements.txt
RUN echo "service nginx start\n \
uwsgi --ini /home/sample_proj/confs/uwsgi.ini" > /tmp/runscript.exe

RUN chmod +x /tmp/runscript.exe
ENTRYPOINT /tmp/runscript.exe
