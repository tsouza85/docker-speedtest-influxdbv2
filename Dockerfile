FROM archlinux:latest

RUN pacman -Syu --noconfirm && \
  pacman --needed --noconfirm -S base base-devel && \
  pacman -S pikaur git python-pip --noconfirm && \
  adduser --system speedtest

RUN pikaur -S ookla-speedtest-bin && \
  pikaur -Sc --noconfirm

USER speedtest

WORKDIR /usr/scr/app

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY speedtest.py .

CMD ["python", "-u", "./speedtest.py"]
