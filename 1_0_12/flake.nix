{
  description = ''Amazon Web Services Signature Version 4'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-sigv4-1_0_12.flake = false;
  inputs.src-sigv4-1_0_12.ref   = "refs/tags/1.0.12";
  inputs.src-sigv4-1_0_12.owner = "disruptek";
  inputs.src-sigv4-1_0_12.repo  = "sigv4";
  inputs.src-sigv4-1_0_12.type  = "github";
  
  inputs."nimsha2".owner = "nim-nix-pkgs";
  inputs."nimsha2".ref   = "master";
  inputs."nimsha2".repo  = "nimsha2";
  inputs."nimsha2".dir   = "master";
  inputs."nimsha2".type  = "github";
  inputs."nimsha2".inputs.nixpkgs.follows = "nixpkgs";
  inputs."nimsha2".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."github.com/disruptek/testes".owner = "nim-nix-pkgs";
  inputs."github.com/disruptek/testes".ref   = "master";
  inputs."github.com/disruptek/testes".repo  = "github.com/disruptek/testes";
  inputs."github.com/disruptek/testes".dir   = "";
  inputs."github.com/disruptek/testes".type  = "github";
  inputs."github.com/disruptek/testes".inputs.nixpkgs.follows = "nixpkgs";
  inputs."github.com/disruptek/testes".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-sigv4-1_0_12"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-sigv4-1_0_12";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}