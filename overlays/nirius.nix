self: super:

{
  nirius = super.nirius.overrideAttrs (old: {
    version = "git-165e3d8";

    src = super.fetchgit {
      url = "https://git.sr.ht/~tsdh/nirius";
      rev = "165e3d8b12660d5d8aac8a2b37e034fa1c403d83";
      hash = "sha256-Nz+7wVTt6i2owtQ1vWRtU5FtfZMMsn4l98zOrKkk8eM=";
    };

    cargoHash = "";
  });
}
