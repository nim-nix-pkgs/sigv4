{
  description = ''Amazon Web Services Signature Version 4'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-sigv4-1_0_11.flake = false;
  inputs.src-sigv4-1_0_11.owner = "disruptek";
  inputs.src-sigv4-1_0_11.ref   = "1_0_11";
  inputs.src-sigv4-1_0_11.repo  = "sigv4";
  inputs.src-sigv4-1_0_11.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-sigv4-1_0_11"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-sigv4-1_0_11";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}