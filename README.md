# howl-arch-packer

Packer project to build a Vagrant Box for Howl, the virtual OWL build environment

howl-arch-packer is a [Packer](https://www.packer.io/) project to automatically build a vagrant image to be used as virtual build environment for [Rebel Technologies OWL audio DSP patch](https://www.rebeltech.org/patch-library/patches/latest) cross compilation and deployment.

Howl should build on any platform, but at this point in time it has only been tested on Mac OS X and the current master branch is still considered experimental and not stable.

This work has been based on Aaaron Bull Shaefers [packer-arch](https://github.com/elasticdog/packer-arch), the rough specs for the virtual machine that is built have stayed the same for this project, take a look at his repository readme for [details](https://github.com/elasticdog/packer-arch/blob/master/README.md).

## Howl on Vagrantcloud
The htaudio-de/arch-howl pre-built box image is also hosted on Vagrantcloud. If you intend to use the Howl build environment only, we suggest you install the box from [vagrantcloud directly](https://app.vagrantup.com/htaudio-de/boxes/arch-howl).

## Building a new Howl Image
In order to build a vagrant Howl image you need an internet connection. In addition to this make sure you have following dependencies installed
* [Vagrant](https://www.vagrantup.com/)
* [Packer](https://www.packer.io/), also available from Hashicorp
* [VirtualBox](https://www.virtualbox.org/), a hypervisor (currently only supported provider)

This Packer build template only supports virtualbox providers, extending the project templates for other supported providers such as VMWare for example should be straight forward.
Once you have made sure you have all dependencies installed run the following (from the root source folder) to validate the Packer template and then build a new image:

    $ packer validate
    $ packer build -only=vmware-iso arch-howl-template.json

Alternatively you can use the `wrapacker` script to wrap the `packer build` call and set some additional build options, such as language mappings etc. `wrapacker` can automatically download the latest ISO images from the
available mirrors within a country you can define. Use the `--help` option for more on how to do this and further options.

## Importing your Howl image to Vagrant
If all goes well Packer will place your new Vagrant box image into the `./output` folder after the build has finished. Run the following commands to import the new box and then listing all vagrant boxes to check if the import worked:

    $ vagrant box add htaudio-de/arch-howl output/packer_arch_howl_virtualbox.box
    $ vagrant box list

After that you should ready to use this box with vagrant.
