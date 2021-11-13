FROM archlinux:base-devel

RUN pacman -Syu --needed --noconfirm && \
  pacman -S git python-pip --needed --noconfirm && \
  git clone https://aur.archlinux.org/paru.git && \
  cd paru && \
  makepkg -si --needed --noconfirm && \
  paru -S ookla-speedtest-bin && \
  paru -Sc --noconfirm && \
  adduser --system speedtest

USER speedtest

WORKDIR /usr/scr/app

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY speedtest.py .

CMD ["python", "-u", "./speedtest.py"]
