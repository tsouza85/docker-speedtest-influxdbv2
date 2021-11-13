FROM archlinux:latest

RUN pacman -Syu --noconfirm && \
  pacman --needed --noconfirm -S base base-devel && \
  pacman -S git curl paru python-pip --noconfirm && \
  paru -Sc --noconfirm && \
  adduser --system speedtest

USER speedtest

WORKDIR /usr/scr/app

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY speedtest.py .

CMD ["python", "-u", "./speedtest.py"]
