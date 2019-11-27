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

Any solution that conveys information used for security purposes, whether
such information is in the form of Evidence, Attestation Results, or
Endorsements, or Appraisal Policy, needs to support end-to-end integrity protection
and replay attack prevention, and often also needs to support additional
security protections.  For example, additional means of authentication,
confidentiality, integrity, replay, denial of service and privacy
protection are needed in many use cases.

To evaluate the security provided by a particular Appraisal Policy, it
is important to understand the strength of the Root of Trust, e.g.,
whether it is mutable software, or firmware that is read-only after
boot, or immutable hardware/ROM.

It is also important that the Appraisal Policy was itself obtained
securely.  As such, if Appraisal Policy in a Relying Party or Verifier
can be configured via a network protocol, the ability to attest to
the health of the client providing the Appraisal Policy needs to be
considered.

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
