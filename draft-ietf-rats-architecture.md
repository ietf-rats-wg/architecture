---
title: Remote Attestation Procedures Architecture
abbrev: RATS Arch & Terms
docname: draft-ietf-rats-architecture-latest
wg: RATS Working Group
stand_alone: true
ipr: trust200902
area: Security
kw: Internet-Draft
cat: info
pi:
  toc: yes
  sortrefs: yes
  symrefs: yes

author:
- ins: H. Birkholz
  name: Henk Birkholz
  org: Fraunhofer SIT
  abbrev: Fraunhofer SIT
  email: henk.birkholz@sit.fraunhofer.de
  street: Rheinstrasse 75
  code: '64295'
  city: Darmstadt
  country: Germany
- ins: D. Thaler
  name: Dave Thaler
  org: Microsoft
  email: dthaler@microsoft.com
  street: ""
  code: ""
  city: ""
  region: ""
  country: USA
- ins: M. Richardson
  name: Michael Richardson
  org: Sandelman Software Works
  email: mcr+ietf@sandelman.ca
  street: ""
  code: ""
  city: ""
  region: ""
  country: Canada
- ins: N. Smith
  name: Ned Smith
  org: Intel Corporation
  abbrev: Intel
  email: ned.smith@intel.com
  street: ""
  code: ""
  city: ""
  country: USA

normative:

informative:

--- abstract

In network protocol exchanges, it is often the case that
one entity (a Relying Party) requires evidence about a remote peer to assess the peer's
trustworthiness, and a way to appraise such evidence. The evidence is typically a set of claims
about its software and hardware platform. This document describes an architecture for such
remote attestation procedures (RATS).

--- middle

# Introduction

# Terminology {#terminology}

    <this section can include content from Terminology in draft-birkholz-rats-architecture
    and draft-thaler-rats-architecture>

# Reference Use Cases {#referenceusecases}

    <unclear if the WG wants this section in the arch doc>

# Topological Models {#overview}

There are multiple possible models for communication between an Attester,
a Verifier, and a Relying Party.  This section includes some reference models,
but this is not intended to be a restrictive list, and other variations may exist.

## Passport Model

In this model, an Attester sends Evidence to a Verifier, which compares
the Evidence against its Appraisal Policy.  The Verifier then gives back
an Attestation Result.  If the Attestation Result was a successful one,
the Attester can then present the Attestation Result to a Relying Party,
which then compares the Attestation Result against its own Appraisal Policy.

Since the resource access protocol between the Attester and Relying Party
includes an Attestation Result, in this model the details of that protocol
constrain the serialization format of the Attestation Result. The
format of the Evidence on the other hand is only constrained by the
Attester-Verifier attestation protocol.

~~~~
      +-------------+
      |             | Compare Evidence
      |   Verifier  | against Appraisal Policy
      |             |
      +-------------+
           ^    |
   Evidence|    |Attestation
           |    |  Result
           |    v
      +-------------+               +-------------+ 
      |             |-------------->|             | Compare Attestation
      |   Attester  |  Attestation  |   Relying   | Result against
      |             |     Result    |    Party    | Appraisal Policy
      +-------------+               +-------------+
~~~~
{: #passport title="Passport Model"}

The passport model is so named because of its resemblance to how nations issue
passports to their citizens. The nature of the Evidence that an individual needs
to provide to its local authority is specific to the country involved. The citizen
retains control of the resulting passport document and presents it to other entities
when it needs to assert a citizenship or identity claim, such as an airport immigration
desk. The passport is considered sufficient because it vouches for the citizenship and
identity claims, and it is issued by a trusted authority. Thus, in this immigration
desk analogy, the passport issuing agency is a Verifier, the passport is an Attestation
Result, and the immigration desk is a Relying Party.

## Background-Check Model

In this model, an Attester sends Evidence to a Relying Party, which simply
passes it on to a Verifier.  The Verifier then compares the Evidence against
its Appraisal Policy, and returns an Attestation Result to the Relying Party.
The Relying Party then compares the Attestation Result against its own security
policy.

The resource access protocol between the Attester and Relying Party
includes Evidence rather than an Attestation Result, but that Evidence is 
not processed by the Relying Party.  Since the Evidence is merely forwarded
on to a trusted Verifier, any serialization format can be used
for Evidence because the Relying Party does not need a parser for it.
The only requirement is that the Evidence can be *encapsulated in* the format
required by the resource access protocol between the Attester and Relying Party.

However, like in the Passport model, an Attestation Result is still consumed by the
Relying Party and so the serialization format of the Attestation Result is still
important.  If the Relying Party is a constrained node whose purpose is to serve
a given type resource using a standard resource access protocol, it already needs
the parser(s) required by that existing protocol.  Hence, the ability to let the
Relying Party obtain an Attestation Result in the same serialization format allows
minimizing the code footprint and attack surface area of the Relying Party, especially
if the Relying Party is a constrained node.

~~~~
                                 +-------------+
                                 |             | Compare Evidence
                                 |   Verifier  | against Appraisal Policy
                                 |             |
                                 +-------------+
                                     ^    |
                             Evidence|    |Attestation
                                     |    |  Result
                                     |    v
   +-------------+               +-------------+
   |             |-------------->|             | Compare Attestation
   |   Attester  |   Evidence    |   Relying   | Result against
   |             |               |    Party    | Appraisal Policy
   +-------------+               +-------------+
~~~~
{: #backgroundcheck title="Background-Check Model"}

The background-check model is so named because of the resemblance of how employers and volunteer
organizations perform background checks. When a prospective employee provides claims about
education or previous experience, the employer will contact the respective institutions or
former employers to validate the claim. Volunteer organizations often perform police background
checks on volunteers in order to determine the volunteer's trustworthiness.
Thus, in this analogy, a prospective volunteer is an Attester, the organization is the Relying Party,
and a former employer or government agency that issues a report is a Verifier.

## Combinations

One variation of the background-check model is where the Relying Party
and the Verifier on the same machine, and so there is no need for a protocol between the two.

It is also worth pointing out that the choice of model is generally up to the Relying Party,
and the same device may need to attest to different Relying Parties for different use cases
(e.g., a network infrastructure device to gain access to the network, and then a
server holding confidential data to get access to that data).  As such, both models may
simultaneously be in use by the same device.

{{combination}} shows another example of a combination where Relying Party 1 uses the 
passport model, whereas Relying Party 2 uses an extension of the background-check model.
Specifically, in addition to the basic functionality shown in {{backgroundcheck}}, Relying Party 2 
actually provides the Attestation Result back to the Attester, allowing the Attester to
use it with other Relying Parties.  This is the model that the Trusted Application Manager
plans to support in the TEEP architecture {{?I-D.ietf-teep-architecture}}.

~~~~
      +-------------+
      |             | Compare Evidence
      |   Verifier  | against Appraisal Policy
      |             |
      +-------------+
           ^    |
   Evidence|    |Attestation
           |    |  Result
           |    v
      +-------------+
      |             | Compare
      |   Relying   | Attestation Result
      |   Party 2   | against Appraisal Policy
      +-------------+
           ^    |
   Evidence|    |Attestation
           |    |  Result
           |    v
      +-------------+               +-------------+ 
      |             |-------------->|             | Compare Attestation
      |   Attester  |  Attestation  |   Relying   | Result against
      |             |     Result    |   Party 1   | Appraisal Policy
      +-------------+               +-------------+
~~~~
{: #combination title="Example Combination"}

# Two Types of Environments

    <this section can include Two Types of Environments content from draft-birkholz-rats-architecture
    but can we find a better name? also this could be a subsection of something else?>

# Trust Model

    <this section can include Trust Model content from draft-thaler-rats-architecture, and
    content from Roles section in draft-birkholz-rats-architecture>

# Conceptual Messages {#messages}

    <this section can include content from Serialization Formats and Conceptual Messages sections from
    draft-thaler-rats-architecture, and Role Messages content from draft-birkholz-rats-architecture>

{:multievidence: artwork-align="center"}
~~~~ MULTIEVIDENCE
{::include multi-evidence.txt}
~~~~
{:multievidence #multievidence_diag title="Multiple Attesters and Relying Parties with Different Formats"}

# Freshness

    <this section can include some high-level content from draft-birkholz-rats-reference-interaction-model>

# Privacy Considerations

The conveyance of Evidence and the resulting Attestation Results
reveal a great deal of information about the internal state of a
device.  In many cases, the whole point of the Attestation process is
to provide reliable information about the type of the device and the
firmware/software that the device is running.  This information is
particularly interesting to many attackers. For example, knowing that a device is
running a weak version of firmware provides a way to aim
attacks better.

Protocols that convey Evidence or Attestation Results are responsible for
detailing what kinds of information are disclosed, and to whom they are exposed.

# Security Considerations

    <this section can include Security Considerations from draft-birkholz-rats-architecture
    and draft-thaler-rats-architecture>

# IANA Considerations

This document does not require any actions by IANA.

# Acknowledgments

Special thanks go to David Wooten, Jörg Borchert, Hannes Tschofenig, Laurence Lundblade, Diego Lopez,
Jessica Fitzgerald-McKay, Frank Xia, and Nancy Cam-Winget.

# Contributors

Thomas Hardjono created older versions of the terminology section in collaboration with Ned Smith.
Eric Voit provided the conceptual separation between Attestation Provision Flows and Attestation Evidence Flows.
Monty Wisemen created the content structure of the first three architecture drafts.
Carsten Bormann provided many of the motivational building blocks with respect to the Internet Threat Model.
