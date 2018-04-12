# howl-arch-packer

Packer project to build a Vagrant Box for Howl, the virtual OWL build environment

Howl arch packer is a Packer project to automatically build a vagrant image to be used as virtual build environment for OWL audio dsp patch cross compilation and deployment.
Read more about Packer here and about the Rebel Technology OWL project here.

Howl should build on any platform, but at this point in time it has only been tested on Mac OS X and the current master branch is currently considered experimental and not stable.

## Howl on Vagrantcloud

## Building a new Howl Image
In order to build a vagrant Howl image make sure you have following dependencies installed
* Vagrant
* Packer, also available from Hashicorp
* Virtualbox, a hypervisor
The Packer template currently only supports virtualbox providers, extending the project templates for other supported providers such as VMWare for example should be straight forward.
Once you have made sure you have the dependencies installed run the following to validate the project and then build a new image:

    $ packer validate
    $ packer build -only=vmware-iso arch-howl-template.json

Alternatively you can use the `wrapacker` script to wrap the `packer build` call and set some additional build options, such as language mappings etc.`wrapacker` can automatically download the latest ISO images from the
available mirrors within a set country. Use the `--help` option for more.

Importing your Howl image to Vagrant
If all goes well Packer will place your new Vagrant box image into the `./output` folder after the build has finished. Run the following commands to import the new box and then listing all vagrant boxes to check if the import worked:

    $ vagrant box add htaudio-de/arch-howl output/packer_arch_howl_virtualbox.box
    $ vagrant box list

After that you are ready to use this vagrant box.
