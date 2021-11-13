FROM archlinux:base-devel

RUN pacman -Syu git python-pip --needed --noconfirm && \
  pacman-key --init && \
  pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com && \
  pacman-key --lsign-key 3056513887B78AEB && \
  pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' --noconfirm && \
  echo '[chaotic-aur]' >> /etc/pacman.conf && \
  echo 'Include = /etc/pacman.d/chaotic-mirrorlist' >> /etc/pacman.conf && \
  pacman -Syu paru --needed --noconfirm && \
  paru -Syu ookla-speedtest-bin && \
  paru -Sc --noconfirm && \
  useradd -m speedtest
  #mkdir /usr/src/app && \
  #chown speedtest /usr/src/app

USER speedtest

WORKDIR /usr/scr/app

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY speedtest.py .

CMD ["python", "-u", "./speedtest.py"]
