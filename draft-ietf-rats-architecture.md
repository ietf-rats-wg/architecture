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
one entity (a relying party) requires evidence about a remote peer to assess the peer's
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

    <this section can include Message Flows from draft-birkholz-rats-architecture and
    Architectural Models from draft-thaler-rats-architecture>

# Two Types of Environments

    <this section can include Two Types of Environments content from draft-birkholz-rats-architecture
    but can we find a better name? also this could be a subsection of something else?>

# Trust Model

    <this section can include Trust Model content from draft-thaler-rats-architecture, and
    content from Roles section in draft-birkholz-rats-architecture>

# Conceptual Messages {#messages}

    <this section can include content from Serialization Formats and Conceptual Messages sections from
    draft-thaler-rats-architecture, and Role Messages content from draft-birkholz-rats-architecture>

    ## Working with Multiple Attestation Evidence Formats

    Verifiers may support Evidence formats besides the preferred EAT format. To reduce unnecessary complexity in Relying Parties it is recommended that Verifier and Relying Party standardize on the EAT token format for Attestation Results.

{:multiev: artwork-align="center"}
~~~~ MULTIFORMAT
{::include multi-evidence.txt}
~~~~
{:multiev #multiev_diag title="RATS Multiple Evidence Formats Flow"}

# Freshness

    <this section can include some high-level content from draft-birkholz-rats-reference-interaction-model>

# Privacy Considerations

    <this section can include Privacy Considerations from draft-birkholz-rats-architecture>

# Security Considerations

    <this section can include Security Considerations from draft-birkholz-rats-architecture
    and draft-thaler-rats-architecture>

# IANA Considerations

    <this section can include IANA Considerations from draft-thaler-rats-architecture>

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
