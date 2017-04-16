#!/bin/bash
mkdir -p /metadata
mkdir -p /oradata/innovation
mkdir -p /archivelogs/orainnov
mkdir -p /archivelogs/oraprod
mkdir -p /controlfiles/oraprod
mkdir -p /oradata/pdf2
mkdir -p /oradata/proddata
mkdir -p /archivelogs/xdeprod
mkdir -p /controlfiles/xdeprod
mkdir -p /oradata/xdeprod
mkdir -p /oradata/pdf
mkdir -p /mnt/oraprod
mkdir -p /backups

chown -R oracle:oracle /metadata /controlfiles/ /archivelogs/ /oradata/ /backups /mnt/oraprod

