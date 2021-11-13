FROM archlinux:base-devel

RUN pacman -Syu --needed --noconfirm && \
  pacman -S git python-pip --needed --noconfirm && \
  useradd --system --no-create-home speedtest && \
  mkdir /usr/src/app && \
  chown speedtest /usr/src/app

RUN pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com; \
  pacman-key --lsign-key 3056513887B78AEB; \
  pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' --noconfirm; \
  echo '[chaotic-aur]' >> /etc/pacman.conf; \
  echo 'Include = /etc/pacman.d/chaotic-mirrorlist' >> /etc/pacman.conf; \
  pacman -Syu paru --needed --noconfirm;

RUN paru -Syu ookla-speedtest-bin; \
  paru -Sc --noconfirm

#USER speedtest

#WORKDIR /usr/scr/app

#RUN git clone https://aur.archlinux.org/paru.git && \
#  cd paru && \
#  makepkg -si --needed --noconfirm

#USER root

#RUN paru -S ookla-speedtest-bin && \
#  paru -Sc --noconfirm &&

USER speedtest

WORKDIR /usr/scr/app

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY speedtest.py .

CMD ["python", "-u", "./speedtest.py"]
