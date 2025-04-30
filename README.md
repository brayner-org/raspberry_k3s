# The Raspberry K3s Journey

- [The Raspberry K3s Journey](#the-raspberry-k3s-journey)
  - [1. Requirements](#1-requirements)
  - [2. Prepare the microSD](#2-prepare-the-microsd)
  - [3. .env](#3-env)
  - [4. Deploy](#4-deploy)
  - [5. Test](#5-test)
  - [6. Destroy](#6-destroy)


## 1. Requirements

- Raspberry Pi
- [Justfile](https://github.com/casey/just)
- [Pre-commit](https://pre-commit.com/)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- [Raspberry Pi Imager](https://www.raspberrypi.com/software/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)

## 2. Prepare the microSD

Install the ubuntu server (I'm using 25.04) on microSD by using the Raspberry Pi Imager. Customize the settings and add your public key so that you can access the raspberry pi via SSH.

## 3. .env

Add the required variables to a `.env` file, so create it. Follow the `.env.example` file.

## 4. Deploy

The following command will setup the raspberry pi, install k3s and home assistant.

```bash
just deploy
```

If you just want to deploy the home assistant to an already deployed k3s cluster, just run:

```bash
just deploy-home-assistant-only
```

## 5. Test

Test the connectivity to your cluster by running:

```bash
just test
```

## 6. Destroy

The below command will destroy the k3s cluster:

```bash
just destroy
```


