{
  description = ''Amazon Web Services Signature Version 4'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-sigv4-1_3_0.flake = false;
  inputs.src-sigv4-1_3_0.ref   = "refs/tags/1.3.0";
  inputs.src-sigv4-1_3_0.owner = "disruptek";
  inputs.src-sigv4-1_3_0.repo  = "sigv4";
  inputs.src-sigv4-1_3_0.type  = "github";
  
  inputs."nimsha2".owner = "nim-nix-pkgs";
  inputs."nimsha2".ref   = "master";
  inputs."nimsha2".repo  = "nimsha2";
  inputs."nimsha2".dir   = "master";
  inputs."nimsha2".type  = "github";
  inputs."nimsha2".inputs.nixpkgs.follows = "nixpkgs";
  inputs."nimsha2".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."github.com/disruptek/balls".owner = "nim-nix-pkgs";
  inputs."github.com/disruptek/balls".ref   = "master";
  inputs."github.com/disruptek/balls".repo  = "github.com/disruptek/balls";
  inputs."github.com/disruptek/balls".dir   = "";
  inputs."github.com/disruptek/balls".type  = "github";
  inputs."github.com/disruptek/balls".inputs.nixpkgs.follows = "nixpkgs";
  inputs."github.com/disruptek/balls".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-sigv4-1_3_0"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-sigv4-1_3_0";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}